Extension { #name : #MethodContext }

{ #category : #'*GT-PetitParserDebugger' }
MethodContext >> locateRootPPParser [
	"Find the last context starting from the top of the stack (or the first starting from the bottom of the stack)
	that was created by a PPParser"
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
	"Find the first context, starting from the top the stack that was created by a PPParser. "
	
	^ (self findContextSuchThat:  [ :ctx | 
			(ctx receiver class inheritsFrom: PPParser) and: [ ctx selector = #parseOn: ] ])
	
	

]
