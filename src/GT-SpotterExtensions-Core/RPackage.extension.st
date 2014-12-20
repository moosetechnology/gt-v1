Extension { #name : #RPackage }

{ #category : #'*GT-SpotterExtensions-Core' }
RPackage >> spotterActDefault [
	^ Nautilus openOnPackage: self
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
RPackage >> spotterTagsFor: aStep [
	<spotterOrder: 20>
	self classTags size <= 1 ifTrue: [ ^ self ].
	aStep listProcessor
			allCandidates: [ self classTags sorted: [ :a :b | a name < b name ] ];
			title: 'Tags';
			matchSubstring
]
