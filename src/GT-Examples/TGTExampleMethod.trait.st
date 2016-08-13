Trait {
	#name : #TGTExampleMethod,
	#category : #'GT-Examples-Organization'
}

{ #category : #ui }
TGTExampleMethod >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	self exists ifFalse: [ ^ self ].
	
	aComposite pharoMethod
		title: [ self gtDisplayString ]; 
		display: [ :entity | entity method sourceCode ];
		smalltalkClass: [ self method methodClass ];
		entity: self
]
