Class {
	#name : #GTPlaformTag,
	#superclass : #GTStatementListTag,
	#instVars : [
		'blockOpen'
	],
	#category : #'GT-Metaceller-Stream'
}

{ #category : #accessing }
GTPlaformTag >> blockOpen [
	^blockOpen ifNil: [ false ]
]

{ #category : #generating }
GTPlaformTag >> closeTag [
	self blockOpen ifTrue: [ 
		self stream space; nextPut: $].
		blockOpen := false ]
]

{ #category : #generating }
GTPlaformTag >> platformName: aPlatformName [
	self stream nextPutAll: 'aSpec for: '.
	aPlatformName asSymbol asCodeStringOn: self stream.
	self stream nextPutAll: ' do: ['.
	blockOpen := true.
]
