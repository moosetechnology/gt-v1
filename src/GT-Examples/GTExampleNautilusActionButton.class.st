Class {
	#name : #GTExampleNautilusActionButton,
	#superclass : #GTAbstractExampleNautilusActionButton,
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleNautilusActionButton class >> methodUpdated: aCompiledMethod with: aResult [
	MethodWidget methodsIconsCache 
		at: aCompiledMethod 
		ifPresent: [ :holder | 
			holder labelGraphic: (self iconForMethod: aCompiledMethod result: aResult) ]
]

{ #category : #order }
GTExampleNautilusActionButton >> privateActionIcon [
	"Return the icon for this action"
	^ IconicButton new
		target: self;
		actionSelector: #run:;
		arguments: { method };
		labelGraphic: (self class iconForMethod: method result: nil);
		color: Color transparent;
		helpText: 'Run';
		extent: 16 @ 16;
		borderWidth: 0
]

{ #category : #private }
GTExampleNautilusActionButton >> run: aCompiledMethod [
	aCompiledMethod gtExample ifNotNil: [ :example | 
		example result ifNotNil: [ :result |
			result isSuccess 
				ifTrue: [ result returnValue inspect ]
				ifFalse: [ example debug ] ] ]
]
