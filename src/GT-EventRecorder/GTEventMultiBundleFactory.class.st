"
I know how to create GTEventMultiBundle object from a collection of GTEventBundle objects.
"
Class {
	#name : #GTEventMultiBundleFactory,
	#superclass : #Object,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #accessing }
GTEventMultiBundleFactory class >> default [
	^ self new
]

{ #category : #public }
GTEventMultiBundleFactory class >> fromBundles: aCollection [ 
	^ self default fromBundles: aCollection
]

{ #category : #public }
GTEventMultiBundleFactory >> fromBundles: aCollection [ 
	| multiBundles |
	multiBundles := OrderedDictionary new.
	aCollection do: [ :aBundle | | multiBundle |
		multiBundle := multiBundles 
								at: aBundle url 
								ifAbsentPut: [ GTEventMultiBundle new url: aBundle url; yourself ].
		multiBundle add: aBundle ].
	^ multiBundles asOrderedCollection
]
