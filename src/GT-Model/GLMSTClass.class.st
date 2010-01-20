Class {
	#name : #GLMSTClass,
	#superclass : #GLMSTBehavior,
	#category : #'GT-Model'
}

{ #category : #accessing }
GLMSTClass >> superclass [
	self class behavior: self stBehavior superclass environment: self environment

]
