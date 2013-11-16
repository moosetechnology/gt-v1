Class {
	#name : #GTBrowseMethodDebuggerAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger'
}

{ #category : #registration }
GTBrowseMethodDebuggerAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousBrowse
]

{ #category : #accessing }
GTBrowseMethodDebuggerAction >> defaultLabel [

	^ 'Browse'
]

{ #category : #accessing }
GTBrowseMethodDebuggerAction >> defaultOrder [

	^ 200
]

{ #category : #actions }
GTBrowseMethodDebuggerAction >> executeAction [
	Smalltalk tools browser 
	fullOnClass: self debugger selectedContext methodClass
 	selector: self debugger selectedContext selector
]

{ #category : #accessing }
GTBrowseMethodDebuggerAction >> id [

	^ #gtBrowseMethodDebuggerAction
]
