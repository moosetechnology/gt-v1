Extension { #name : #MethodContext }

{ #category : #'*GT-PetitParserDebugger' }
MethodContext >> locateRootPPParser [
	| parserContext currentContext |

	parserContext := nil.
	currentContext := self.
	[ 
		(currentContext := currentContext locateTopPPParser) notNil
	 ] whileTrue: [ 
		parserContext := currentContext.
		currentContext := currentContext sender ].

	^ parserContext
]

{ #category : #'*GT-PetitParserDebugger' }
MethodContext >> locateTopPPParser [
	
	^ (self findContextSuchThat:  [ :ctx | 
			(ctx receiver class inheritsFrom: PPParser) and: [ ctx selector = #parseOn: ] ])
	
	

]
