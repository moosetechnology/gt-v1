Class {
	#name : #GTOBCommandAdaptor,
	#superclass : #Object,
	#category : #'GT-Model'
}

{ #category : #'as yet unclassified' }
GTOBCommandAdaptor >> actionsFrom: aCollectionOfOBCommandClasses on: aTarget for: aRequestor [
	^ (aCollectionOfOBCommandClasses "select: [ :each | each isActive ]") collect: [ :each |
		| command |
		command := each on: aTarget for: aRequestor.
		GLMAction new
			icon: command icon;
			title: command label;
			action: [:presentation | command execute ];
			yourself 
		]
]
