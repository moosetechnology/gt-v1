Extension { #name : #MCWorkingCopy }

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> allAncestors [
	^ self versionInfo 
		ifNotNilDo: [ :versionInfo | versionInfo allAncestors ]
		ifNil: [ #() ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> gtDisplayOn: stream [
	ancestry ancestors isEmpty 
		ifTrue: [ 
			super gtDisplayOn: stream. stream nextPutAll: ' (unsaved)' ]
		ifFalse: [ 
			ancestry ancestors first gtDisplayOn: stream.
			self needsSaving ifTrue: [ stream nextPutAll: ' (modified)' ] ]
		
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> nextAncestors [
	^ self versionInfo 
		ifNotNilDo: [ :versionInfo | versionInfo ancestors ]
		ifNil: [ #() ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterAllRepositoriesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
		title: 'All other repositories';
		allCandidates: [ MCRepositoryGroup default repositories \ self repositoryGroup repositories ];
		itemName: [ :item | item description ];
		actLogic: [ :item | self spotterCommit: self in: item ];
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterAncestorsFor: aStep [
	<spotterOrder: 2>
	aStep listProcessor
		title: 'Ancestors';
		allCandidates: [ self allAncestors ];
		actLogic: [ :aMCVersionInfo | aMCVersionInfo diffAgainstWorkingCopy ];
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterCommit: workingCopy in: aRepository [
	| newVersion |

	newVersion := workingCopy newVersionIn: aRepository.
	newVersion ifNil: [ ^ self ].
	Cursor wait showWhile: [
		[ 	aRepository storeVersion: newVersion.
			aRepository storeDependencies: newVersion ] 
		ensure: [ (MCVersionInspector new version: newVersion) show ]]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterMonticelloPackageFor: aStep [
	<spotterOrder: 21>
	aStep listProcessor
		title: 'Monticello';
		allCandidates: [ Array with: self package ];
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterPackageFor: aStep [
	<spotterOrder: 21>
	aStep listProcessor
		title: 'Packages';
		allCandidates: [ Array with: self package correspondingRPackage ];
		itemName: [ :item | item name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterPackageRepositoriesFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
		title: 'Package repositories';
		allCandidates: [ self repositoryGroup repositories ];
		itemName: [ :item | item description ];
		actLogic: [ :item | self spotterCommit: self in: item ];
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> versionInfo [
	^ self ancestors 
		ifNotEmptyDo: [ :list | list first ] 
		ifEmpty: [ nil ]
]
