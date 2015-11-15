Class {
	#name : #GTEventMultiBundleFactory,
	#superclass : #Object,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #'as yet unclassified' }
GTEventMultiBundleFactory class >> default [
	^ self new
]

{ #category : #'as yet unclassified' }
GTEventMultiBundleFactory class >> fromBundles: aCollection [ 
	^ self default fromBundles: aCollection
]

{ #category : #'as yet unclassified' }
GTEventMultiBundleFactory >> fromBundles: aCollection [ 
	| multiBundles |
	multiBundles := StandardOrderedDictionary new.
	aCollection do: [ :aBundle | | multiBundle |
		multiBundle := multiBundles 
								at: aBundle url 
								ifAbsentPut: [ GTEventMultiBundle new url: aBundle url; yourself ].
		multiBundle add: aBundle ].
	^ multiBundles asOrderedCollection
]
