Extension { #name : #RPackage }

{ #category : #'*GT-Spotter' }
RPackage >> spotterActDefault [
	^ Nautilus openOnPackage: self
]

{ #category : #'*GT-Spotter' }
RPackage >> spotterClassesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			allCandidates: [ self definedClasses sorted: [ :a :b | a name < b name ] ];
			title: 'Classes';
			matchSubstring
]
