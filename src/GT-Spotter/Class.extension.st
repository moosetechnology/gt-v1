Extension { #name : #Class }

{ #category : #'*GT-Spotter' }
Class >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-Spotter' }
Class >> spotterClassInstanceVariablesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Class instance variables';
			allCandidates: [ self class layout allSlots ];
			itemName: [:each | each name asString];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
Class >> spotterClassMethodsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Class methods';
			allCandidates: [ self class methods ];
			itemName: [ :method | method selector ];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
Class >> spotterInstanceVariablesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Instance variables';
			allCandidates: [ self layout allSlots ];
			itemName: [:each | each name asString];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
Class >> spotterMethodsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Instance methods';
			allCandidates: [ self methods ];
			itemName: [ :method | method selector ];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
Class >> spotterReferenceFor: aStep [
	<spotterOrder: 30>
	aStep listProcessor
			title: 'References';
			allCandidates: [ SystemNavigation default allReferencesTo: self binding ];
			itemName: [ :method | method asString ];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
Class >> spotterSubclassesFor: aStep [
	<spotterOrder: 50>
	aStep listProcessor
			title: 'All subclasses';
			allCandidates: [ self allSubclasses ];
			matchSubstring
]

{ #category : #'*GT-Spotter' }
Class >> spotterSuperclassesFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			title: 'All superclasses';
			allCandidates: [ self deepCollect: #superclass ];
			matchSubstring
]
