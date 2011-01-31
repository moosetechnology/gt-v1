"
This is a utility class to circumvent the design of ProfStef.
"
Class {
	#name : #GTProfStefNoView,
	#superclass : #Object,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTProfStefNoView >> close [
]

{ #category : #'as yet unclassified' }
GTProfStefNoView >> open [

]

{ #category : #'as yet unclassified' }
GTProfStefNoView >> showLesson: aLesson [
	^ aLesson lesson
]

{ #category : #'as yet unclassified' }
GTProfStefNoView >> showLesson: aLesson withTitle: aString [
	^ aLesson
]

{ #category : #'as yet unclassified' }
GTProfStefNoView >> showTutorialNode: aTutorialNode [
	^ aTutorialNode 
]
