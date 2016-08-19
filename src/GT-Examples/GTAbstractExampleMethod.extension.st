Extension { #name : #GTAbstractExampleMethod }

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleMethod >> addToSelectorEnvironment: aSelectorEnvironment [
	self exists ifFalse: [ ^ self ].
	
	aSelectorEnvironment addClass: self methodClass selector: self selector
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleMethod >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse Method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleMethod >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: self methodClassName asString; 
		nextPutAll: ' >> #'; 
		nextPutAll: self selector asString.
		
	self gtDisplayValidityOn: aStream
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleMethod >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	self exists ifFalse: [ ^ self ].
	
	aComposite pharoMethod
		title: [ self gtDisplayString ]; 
		display: [ :entity | entity method sourceCode ];
		smalltalkClass: [ self method methodClass ];
		entity: self
]
