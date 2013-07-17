Class {
	#name : #GTPPContextLocator,
	#superclass : #Object,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPContextLocator >> locateRootParserContextFor: aContext [
	| parserContext currentContext |

	parserContext := nil.
	currentContext := aContext.
	[ 
		(currentContext := (currentContext findContextSuchThat:  [ :ctx | 
			(ctx receiver class inheritsFrom: PPParser) and: [ ctx selector = #parseOn: ] ]) ) notNil
	 ] whileTrue: [ 
		parserContext := currentContext.
		currentContext := currentContext sender ].

	^ parserContext
	
	
]
