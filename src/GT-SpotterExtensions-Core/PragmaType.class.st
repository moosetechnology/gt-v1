"
This models the type of pragma instances.

It essentially knows the keyword that defines the Pragma, and can obtain all occurences of that Pragma.

!!Example

[[[
	PragmaType all
]]]
"
Class {
	#name : #PragmaType,
	#superclass : #Object,
	#instVars : [
		'keyword',
		'pragmas'
	],
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #accessing }
PragmaType class >> all [
	| pragmas |
	pragmas := OrderedCollection new.
	Object withAllSubclassesDo: [:each |
		Pragma withPragmasIn: each do: [:p |
			pragmas add: p]].
	^ (pragmas groupedBy: #keyword) associations collect: [ :association |
		PragmaType new
			keyword: association key; 
			pragmas: association value ] 
]

{ #category : #examples }
PragmaType class >> gtExampleAnyOne [
	<gtExample>
	^ self all anyOne
]

{ #category : #ui }
PragmaType >> gtInspectorPragmasIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Pragmas';
		display: [ self pragmas ];
		format: #gtDisplayString
]

{ #category : #accessing }
PragmaType >> keyword [
	^ keyword
]

{ #category : #accessing }
PragmaType >> keyword: anObject [
	keyword := anObject
]

{ #category : #accessing }
PragmaType >> pragmas [
	^ pragmas ifNil: [
		pragmas := OrderedCollection new.
		Object withAllSubclassesDo: [ :each |
			Pragma withPragmasIn: each do: [ :p |
				p keyword = self keyword ifTrue: [ 
					pragmas add: p ] ] ].
		pragmas ]
]

{ #category : #accessing }
PragmaType >> pragmas: aCollection [
	pragmas := aCollection
]

{ #category : #ui }
PragmaType >> printOn: stream [
	stream nextPutAll: self keyword
]

{ #category : #ui }
PragmaType >> spotterPragmasFor: aStep [
	<spotterOrder: 40>
	^ aStep listProcessor
		title: 'Pragmas';
		allCandidates: [ self pragmas ];
		itemName: [ :pragma | pragma method printString , ' ' , pragma asString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
PragmaType >> spotterPreviewItemsIn: aComposite [
	<spotterPreview: 10>
	
	aComposite list
		title: '<', self gtDisplayString, '>';
		display: [ :x | x ];
		format: [ :pragma | GTSpotterItemBrick new text: pragma method gtDisplayString; disable; yourself ];
		entity: self pragmas asArray.
]

{ #category : #ui }
PragmaType >> spotterSendersFor: aStep [
	<spotterOrder: 50>
	^ aStep listProcessor
		title: 'Senders';
		filter: GTFilterSubstring item: [ :filter :context | 
			self keyword senders do: [ :sender | 
				filter value: sender compiledMethod ] ]
]
