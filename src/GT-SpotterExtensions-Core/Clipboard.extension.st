Extension { #name : #Clipboard }

{ #category : #'*GT-SpotterExtensions-Core-private' }
Clipboard >> spotterClipboardItems [
	recent isEmptyOrNil ifTrue: [ ^ #() ].
	" all except the first - this is already shown in the previous spotter step "
	^ recent allButFirst reject: [ :each | 
		each isEmptyOrNil 
			or: [ each asString trimBoth isEmptyOrNil ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
Clipboard >> spotterClipboardItemsFor: aStep [
	<spotterOrder: 90>
	recent ifNil: [ ^ self ].
	^ aStep listProcessor
		title: 'Clipboard History';
		items: [ recent copy ];
		itemName: [ :item | item asString contractTo: 100 ];
		itemFilterName: [ :item | item asString ];
		filter: GTFilterSubstrings;
		actLogic: [ :item | item asString inspect ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
Clipboard >> spotterPreviewCodeIn: aComposite [
	<spotterPreview: 10>
	^ aComposite text
		title: 'Contents';
		display: [ :item | item clipboardText asString contractTo: 100 ];
		entity: self
]
