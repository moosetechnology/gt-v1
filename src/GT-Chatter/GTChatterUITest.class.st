"
A GTChatterMorphTest is a test class for testing the behavior of GTChatterMorph
"
Class {
	#name : #GTChatterUITest,
	#superclass : #TestCase,
	#instVars : [
		'client1',
		'client2',
		'client3',
		'ui1'
	],
	#category : #'GT-Chatter-Tests'
}

{ #category : #support }
GTChatterUITest >> basicChat [
	client1 send: 'Hello Client2!' to: 'client2'.
	client2 send: 'Hello Client1!' to: 'client1'.
	client1 send: 'How are you?' to: 'client2'.
	client2 send: 'I am fine. Thanks' to: 'client1'.
	client1 send: 'Hello Client3!' to: 'client3'.
]

{ #category : #running }
GTChatterUITest >> setUp [
	super setUp.
	client1 := GTChatter new clientId: 'client1'; start.
	client2 := GTChatter new clientId: 'client2'; proxy: client1 proxy; start.
	client3 := GTChatter new clientId: 'client3'; proxy: client1 proxy; start.

]

{ #category : #running }
GTChatterUITest >> tearDown [
	client1 ifNotNil: [ :s | client1 := nil. s stop ].
	client2 ifNotNil: [ :s | client2 := nil. s stop ].
	client3 ifNotNil: [ :s | client3 := nil. s stop ].
	ui1 ifNotNil: [ :ui | ui1 := nil. ui delete ].
	super tearDown.
]

{ #category : #tests }
GTChatterUITest >> testOpen [
	self basicChat.
	ui1 := GTChatterUI new
					chatterModel: client1;
					open.

]
