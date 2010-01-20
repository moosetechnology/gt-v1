Class {
	#name : #GTSTPackage,
	#superclass : #GTSTNamedModel,
	#category : #'GT-Model'
}

{ #category : #'instance creation' }
GTSTPackage class >> named: aString environment: anEnvironment [
	^ self new
		name: aString;
		environment: anEnvironment;
		yourself
]

{ #category : #'instance creation' }
GTSTPackage class >> rootPackagesOn: anEnvironment [
	^ ((anEnvironment categories collect: [:string | string readStream upTo: $-]) asSet asSortedCollection)
			collect: [:string | self named: string environment: anEnvironment]
]

{ #category : #accessing }
GTSTPackage >> allClasses [
	| all |
	all := self classes asOrderedCollection.
	self subPackages do: [:each | 
		all addAll: each allClasses ].
	^ all
]

{ #category : #accessing }
GTSTPackage >> classes [
	^ (self environment classNamesFor: self name)
		collect: [:className | GTSTClass behavior: (self environment at: className) environment: self environment ]
]

{ #category : #accessing }
GTSTPackage >> subPackages [
	^ self environment categories
		select: [:string | string  beginsWith: self name, '-']
		thenCollect: [:string  | self class named: string environment: self environment]
]
