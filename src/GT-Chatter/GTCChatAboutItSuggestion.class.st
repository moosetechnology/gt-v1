Class {
	#name : #GTCChatAboutItSuggestion,
	#superclass : #SugsSuggestion,
	#category : #'GT-Chatter-Integration'
}

{ #category : #execution }
GTCChatAboutItSuggestion >> execute [
	self halt.
]

{ #category : #execution }
GTCChatAboutItSuggestion >> isValidForContext [
	^ true
]

{ #category : #accessing }
GTCChatAboutItSuggestion >> label [
	^ 'Chat about it' translated
]
