Extension { #name : #Behavior }

{ #category : #'*GT-SpotterExtensions-Core' }
Behavior >> spotterClassInstanceVariablesFor: aStep [
	<spotterOrder: 25>
	aStep listProcessor
			title: 'Class instance variables';
			allCandidates: [ self class layout allSlots ];
			itemName: [:each | each name asString];
			filterUsing: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Behavior >> spotterInstanceVariablesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Instance variables';
			allCandidates: [ self layout allSlots ];
			itemName: [:each | each name asString];
			filterUsing: GTFilterSubstring
]
