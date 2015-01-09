Extension { #name : #CompiledMethod }

{ #category : #'*GT-Spotter' }
CompiledMethod >> spotterPreviewIn: aCanvas [

	aCanvas pharoMethod
		smalltalkClass: [ self methodClass ];
		display: [ self getSource ]
]
