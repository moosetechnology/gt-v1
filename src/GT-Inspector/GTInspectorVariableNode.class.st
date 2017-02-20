"
I am an abstract inspector variable node.
My main responsibility is to associate a variable name of a host object with its value. 

I am used by Inspector's raw presentation.

Public API and Key Messages

- hostObject return an object (host) which has a variable I represent
- label return a string label of the variable which may be an instance variable name or a dynamically generated name for dynamic variables.
- value return a variable's value
- key return an object used as unique key to associate a variable, it may be an integer for indexed variables or a string for dynamic ones

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	hostObject:		<Object>

    Implementation Points

		HostObject can not be nil
"
Class {
	#name : #GTInspectorVariableNode,
	#superclass : #Object,
	#instVars : [
		'hostObject'
	],
	#category : #'GT-Inspector'
}

{ #category : #'instance creation' }
GTInspectorVariableNode class >> hostObject: anObject [ 
	^ self new
		hostObject: anObject;
		yourself
]

{ #category : #composition }
GTInspectorVariableNode >> childrenNodesFor: aVariablesBrowser [
	"Return a collection of subvariable nodes to be displayed in a given raw variables browser.
	Note: by default we dispatch to browser and let it perform collection"
	<return: #Collection of: #GTInspectorVariableNode>

	^ aVariablesBrowser variableNodesFor: self value
]

{ #category : #accessing }
GTInspectorVariableNode >> hostObject [
	^ hostObject
]

{ #category : #accessing }
GTInspectorVariableNode >> hostObject: anObject [

	"
	Allow nil objects for the moment. Normally the inspector should be able to inspect nil.
	self
		assert: [ anObject isNotNil ]
		description: [ 'Host object must not be nil' ]."

	self
		assert: [ hostObject isNil ]
		description: [ 'Host can be assigned only once' ].

	hostObject := anObject
]

{ #category : #actions }
GTInspectorVariableNode >> inspectorActionsForNode [
	"Return a collection of available inspector actions associated with a variable node"
	<return: #Collection of: #GLMAction>

	^ #()
]

{ #category : #accessing }
GTInspectorVariableNode >> key [
	"Answer the key of this object variable (slot, indexed attribute, computed value)."
	^ self subclassResponsibility
]

{ #category : #accessing }
GTInspectorVariableNode >> label [
	"Answer the label of this object variable (slot, indexed attribute, computed value)."
	^ self key asString
]

{ #category : #accessing }
GTInspectorVariableNode >> value [
	"Answer the object value of this object variable (slot, indexed attribute, computed value)."
	^ self subclassResponsibility
]
