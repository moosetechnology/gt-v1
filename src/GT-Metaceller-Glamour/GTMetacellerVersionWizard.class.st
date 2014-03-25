Class {
	#name : #GTMetacellerVersionWizard,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'version'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #opening }
GTMetacellerVersionWizard >> openOn: aVersion [
	version := aVersion.
	super openOn: aVersion
]
