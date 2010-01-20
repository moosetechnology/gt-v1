Class {
	#name : #GTSTClassCategory,
	#superclass : #GTSTNamedModel,
	#category : #'GT-Model'
}

{ #category : #'as yet unclassified' }
GTSTClassCategory class >> all [
	|env|
	env := self defaultEnvironment.
	^ env categories collect: [:each | self named: each environment: env]
]

{ #category : #accessing }
GTSTClassCategory >> classes [
	^ (Smalltalk organization listAtCategoryNamed: self name) collect: [ :className |
		GTSTClass behavior: (Smalltalk classNamed: className) environment: self environment]
]
