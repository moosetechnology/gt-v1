Extension { #name : #MCWorkingCopy }

{ #category : #'*GT-SpotterExtensions-Core' }
MCWorkingCopy >> spotterAllRepositoriesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
		title: 'All';
		allCandidates: [ MCRepositoryGroup default repositories ];
		itemName: [ :item | item description ];
		actLogic: [ :item | self spotterCommit: self in: item ];
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
MCWorkingCopy >> spotterPackageRepositoriesFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
		title: 'Package';
		allCandidates: [ self repositoryGroup repositories ];
		itemName: [ :item | item description ];
		actLogic: [ :item | self spotterCommit: self in: item ];
		matchSubstring
]
