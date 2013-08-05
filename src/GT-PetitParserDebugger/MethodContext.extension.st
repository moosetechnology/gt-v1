Extension { #name : #MethodContext }

{ #category : #'*GT-PetitParserDebugger' }
MethodContext >> locateRootPPParser [
	| parserContext currentContext |

	parserContext := nil.
	currentContext := self.
	[ 
		(currentContext := (currentContext findContextSuchThat:  [ :ctx | 
			(ctx receiver class inheritsFrom: PPParser) and: [ ctx selector = #parseOn: ] ]) ) notNil
	 ] whileTrue: [ 
		parserContext := currentContext.
		currentContext := currentContext sender ].

	^ parserContext
]
