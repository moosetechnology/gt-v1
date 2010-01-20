Class {
	#name : #GTSTClass,
	#superclass : #GTSTBehavior,
	#category : #'GT-Model'
}

{ #category : #accessing }
GTSTClass >> superclass [
	self class behavior: self stBehavior superclass environment: self environment

]
