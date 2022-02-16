import * as c from 'https://deno.land/std@0.125.0/fmt/colors.ts'

type Entry = {
	names: string[]
	desc: string
	attributes: { attr: string; value: string | null }[]
}

// Parse terminfo database
const entries: Entry[] = []
{
	const text = await Deno.readTextFile('./pkg/share/terminfo.src')

	let currentNames: string[] = []
	let currentDesc = ''
	let currentAttributes: { attr: string; value: string | null }[] = []
	for (const line of text.split('\n')) {
		if (line.length === 0) {
			continue
		}

		if (line[0] === '#') {
			continue
		} else if (line[0] === '\t') {
			if (line[1] === ' ') {
				currentAttributes[currentAttributes.length - 1].value += line.trim()
			} else {
				currentAttributes = currentAttributes.concat(
					line
						.trim()
						.replace(/,$/, '')
						.split(',')
						.map((item: string) => {
							let str = item.trim()

							if (str.includes('=')) {
								return {
									attr: str.split('=')[0],
									value: str.split('=')[1],
								}
							} else {
								return {
									attr: str,
									value: null,
								}
							}
						})
				)
			}
		} else {
			if (currentAttributes.length !== 0) {
				entries.push({
					names: currentNames,
					desc: currentDesc,
					attributes: currentAttributes,
				})
			}

			currentNames = line.split('|').slice(0, -1)
			currentDesc = line.slice(line.indexOf('|') + 1, -1)
			currentAttributes = []
		}
	}

	entries.push({
		names: currentNames,
		desc: currentDesc,
		attributes: currentAttributes,
	})
}

// Replace 'use' attributes with their values. This is obviously slow as hell but I don't care
{
	let has_use_somewhere: boolean
	do {
		has_use_somewhere = false

		for (const entry of entries)
			for (let i = entry.attributes.length - 1; i >= 0; --i) {
				const attr = entry.attributes[i]

				if (attr.attr === 'use') {
					has_use_somewhere = true

					entry.attributes.splice(i, 1)
					let has_found_corresponding_use = false
					for (const entry2 of entries) {
						if (attr.value === null) {
							console.error('Error (code 1)')
							break
						}

						if (entry2.names.includes(attr.value)) {
							has_found_corresponding_use = true
							entry.attributes = entry.attributes.concat(entry2.attributes)
							break
						}
					}

					if (!has_found_corresponding_use) {
						console.error('Error (code 2)')
					}
				}
			}
	} while (has_use_somewhere)
}

const arg = Deno.args[0]
if (arg === '--write') {
	let fileContents = ''

	fileContents += `# shellcheck shell=bash

tty.tput() {
	unset -v REPLY; REPLY=
	local attr="$1"
	local term="\${2:-$TERM}"

	if [ -z $attr ]; then
		printf '%s\\n' "Error: tty.tput: Variable 'attr' cannot be zero"
		return 1
	fi

	local value=
case $term in \n`

	for (const term of entries) {
		fileContents += term.names.join('|')
		fileContents += ')\n'

		fileContents += `	# ${term.desc}\n`
		fileContents += '	case $attr in\n'
		for (const attr of term.attributes) {
			let key = attr.attr
			if (key.match(/'/u)) {
				continue
			}

			let value = attr.value === null ? 'yes' : attr.value
			if (value.match(/'/u)) {
				continue
			}
			value = value.replaceAll('\\E', '\\e')
			value = value.replaceAll('\\(<?!e)', '\\\\')

			fileContents += `		'${key}') value=$'${value}' ;;\n`
		}
		fileContents += `		*) printf '%s\\n' "Error: tty.tput: Unknown terminfo capability '$attr'"; return 1 ;;\n`
		fileContents += '	esac\n'

		fileContents += '	;;\n'
	}

	fileContents += 'esac\n'
	fileContents += 'REPLY=$value\n'
	fileContents += '}\n'

	Deno.writeTextFile('./pkg/src/public/tty-tput.sh', fileContents)
} else if (arg === '--print') {
	for (const term of entries) {
		if (term.names.some((item) => item.match(/kitty|alacritty/))) {
			console.info(`${c.blue('NAME')}
	${JSON.stringify(term.names)}
${c.green('DESCRIPTION')}
	${term.desc}
${c.yellow('ATTRIBUTES')}
	${JSON.stringify(term.attributes)}`)
		}
	}
}
