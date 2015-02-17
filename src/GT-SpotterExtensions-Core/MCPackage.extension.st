Extension { #name : #MCPackage }

{ #category : #'*GT-SpotterExtensions-Core' }
MCPackage >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCPackage >> spotterForPackageFor: aStep [
	<spotterOrder: 2>
	aStep listProcessor
			allCandidates: [ Array with: self correspondingRPackage ];
			title: 'Packages';
			itemName: [ :package | package name ];
			itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCPackage >> spotterMonticelloWorkingCopyFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Monticello';
		allCandidates: [ Array with: self workingCopy ];
		matchSubstring
]
