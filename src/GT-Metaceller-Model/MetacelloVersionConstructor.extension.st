Extension { #name : #MetacelloVersionConstructor }

{ #category : #'*gt-metaceller-model' }
MetacelloVersionConstructor >> versionImportPragmasVerifiedDefinedIn: versionMap [ 
	| pragmaDict |
	pragmaDict := self extractVersionImportPragmas.
	pragmaDict
		keysAndValuesDo: [:versionString :pragmaColl | pragmaColl
				do: [:pragma | (pragma argumentAt: 2)
						do: [:importedVersion | versionMap
								at: importedVersion
								ifAbsent: [pragmaDict
										at: importedVersion
										ifAbsent: [^ self error: 'The imported version:' , importedVersion printString , ' referenced from the method: ' , pragma selector printString , ' in configuration ' , configuration class printString , ' has not been defined.']]]]].
	^ pragmaDict
]
