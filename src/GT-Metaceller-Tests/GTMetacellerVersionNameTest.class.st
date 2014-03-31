Class {
	#name : #GTMetacellerVersionNameTest,
	#superclass : #TestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerVersionNameTest >> testAlpha [
	self assert: ('3.2.alfa' asMetacellerVersion) < ('3.2.beta' asMetacellerVersion).
	self assert: ('alfa.1' asMetacellerVersion) < ('alfa.2' asMetacellerVersion)
]

{ #category : #tests }
GTMetacellerVersionNameTest >> testMissing [
	self assert: ('3.2.1' asMetacellerVersion) > ('3.2' asMetacellerVersion).
	self deny: ('3.2.1' asMetacellerVersion) < ('3.2' asMetacellerVersion)
]

{ #category : #tests }
GTMetacellerVersionNameTest >> testSimple [
	self assert: ('3.2.1' asMetacellerVersion) > ('2.2.1' asMetacellerVersion).
	self assert: ('3.2.1' asMetacellerVersion) > ('3.1.1' asMetacellerVersion).
	self assert: ('3.2.1' asMetacellerVersion) > ('3.2.0' asMetacellerVersion).
]
