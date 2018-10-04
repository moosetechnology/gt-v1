"
I describe a method subject of an example. I should be a subclas of GTExampleSubject, but for now I am external because it seems I have more in common in terms of implementation to GTExampleMethod.
"
Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Subjects'
}

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]
