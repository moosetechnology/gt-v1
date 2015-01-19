Class {
	#name : #GTChatterUI,
	#superclass : #GLMFoundationBrick,
	#instVars : [
		'chatterModel',
		'conversationsBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #accessing }
GTChatterUI >> chatterModel [
	^ chatterModel ifNil: [ chatterModel := GTChatter uniqueInstance ]
]

{ #category : #accessing }
GTChatterUI >> chatterModel: aGTChatter [ 
	chatterModel := aGTChatter.
	self conversationsBrick chatterModel: aGTChatter.
]

{ #category : #accessing }
GTChatterUI >> clientId [
	^ self chatterModel clientId
]

{ #category : #accessing }
GTChatterUI >> conversationsBrick [
	^ conversationsBrick ifNil: [ 
		conversationsBrick := GTConversationsAndMessagesBrick new.
		self addBrickBack: conversationsBrick.
		conversationsBrick ]
]

{ #category : #initialization }
GTChatterUI >> initialize [
	super initialize.
	"self theme chatterWidgetThemer chatterStyleFor: self."
	
]

{ #category : #'instance creation' }
GTChatterUI >> open [
	^ self
		extent: 400@300;
		doLayout; 
		openInWindowLabeled: 'Conversations of ', self clientId asString.
]
