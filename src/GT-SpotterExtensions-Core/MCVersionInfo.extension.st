Extension { #name : #MCVersionInfo }

{ #category : #'*GT-SpotterExtensions-Core' }
MCVersionInfo >> allAncestors [
	^ OrderedCollection streamContents: [ :stream |
		self allAncestorsDo: [ :versionInfo | stream nextPut: versionInfo ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCVersionInfo >> diffAgainstWorkingCopy [
	| repository workingCopy package workingCopyVersion version | 
	workingCopy := (MCWorkingCopy allManagers 
		detect: [ :each | each ancestry hasAncestor: self ]
		ifNone: [ nil ]).
	workingCopy 
		ifNotNil: [
			package := workingCopy package.
			repository := workingCopy repositoryGroup repositories anyOne .
			workingCopyVersion := repository versionWithInfo: workingCopy versionInfo ifAbsent: [ ^ self halt ].
			version := repository versionWithInfo: self ifAbsent: [ ^ self halt ].
			((MCFileRepositoryInspector repository: repository workingCopy: workingCopy) 
				version: version;
				yourself) changes ] 
		ifNil: [ self halt ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCVersionInfo >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCVersionInfo >> spotterAncestorsFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Ancestors';
		allCandidates: [ self allAncestors ];
		actLogic: [ :aMCVersionInfo | aMCVersionInfo diffAgainstWorkingCopy ];
		matchSubstring
]
