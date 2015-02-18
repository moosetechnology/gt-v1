Extension { #name : #RPackage }

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterActDefault [
	^ PackageTreeNautilus openOnPackage: self
]

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterClassesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			allCandidates: [ self definedClasses sorted: [ :a :b | a name < b name ] ];
			title: 'Classes';
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterExtensionMethodsFor: aStep [
	<spotterOrder: 30>
	aStep listProcessor
			allCandidates: [ self extensionMethods ];
			title: 'Extension Methods';
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterMonticelloPackageFor: aStep [
	<spotterOrder: 41>
	aStep listProcessor
		title: 'Monticello Package';
		allCandidates: [ Array with: self mcPackage ];
		itemIcon: [ Smalltalk ui icons iconNamed: #monticelloPackageIcon ];
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterMonticelloWorkingCopyFor: aStep [
	<spotterOrder: 42>
	aStep listProcessor
		title: 'Monticello Working Copy';
		allCandidates: [ Array with: self mcPackage workingCopy ];
		itemIcon: #versionControlIcon;
		matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterPreviewCodeIn: aComposite [
	<spotterPreview: 10>
	aComposite list
		title: 'Preview';
		display: [ :x | x ];
		format: [ :class | GTSpotterItemBrick new text: class gtDisplayString; icon: class systemIcon; disable; yourself ];
		entity: self classes asArray.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterTagsFor: aStep [
	<spotterOrder: 20>
	self classTags size <= 1 ifTrue: [ ^ self ].
	aStep listProcessor
			allCandidates: [ self classTags sorted: [ :a :b | a name < b name ] ];
			title: 'Tags';
			matchSubstring
]
