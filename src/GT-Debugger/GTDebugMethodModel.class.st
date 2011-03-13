"
This class gives a method model for debugging.
"
Class {
	#name : #GTDebugMethodModel,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'method',
		'methodNode',
		'ranges'
	],
	#classVars : [
		'MapCache',
		'MapCacheEntries'
	],
	#category : #'GT-Debugger'
}

{ #category : #'instance creation' }
GTDebugMethodModel class >> forMethod: aMethod [
	^ self new forMethod: aMethod
]

{ #category : #'instance creation' }
GTDebugMethodModel >> forMethod: aMethod [
	method := aMethod.
	methodNode := method methodNode.

	ranges := Dictionary new.
	
	" Put all ranges with a possitive Key PC in the ranges dictionary "
	methodNode rawSourceRanges
		keysAndValuesDo: [ :node :range |
			node pc = 0
				ifFalse: [ ranges at: node pc put: range ]].

	" Sort all the Key PCs in the sortedKeyPCs "
	"sortedKeyPCs := SortedCollection new."
	" ranges keysDo: [ :pc | sortedKeyPCs add: pc ]."
]

{ #category : #accessing }
GTDebugMethodModel >> source [
	^ method holdsTempNames
		ifTrue: [ method getSource ]
		ifFalse: [ methodNode sourceText ]
]

{ #category : #accessing }
GTDebugMethodModel >> sourceRangeForPC: pc [
	^ ranges at: pc ifAbsent: [ ^ 1 to: 0 ].
]

{ #category : #accessing }
GTDebugMethodModel >> sourceText [
	^ self source asText
]
