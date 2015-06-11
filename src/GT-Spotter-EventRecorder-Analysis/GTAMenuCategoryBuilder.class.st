Class {
	#name : #GTAMenuCategoryBuilder,
	#superclass : #Object,
	#instVars : [
		'menuBuilder',
		'categoryBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Category'
}

{ #category : #building }
GTAMenuCategoryBuilder >> build [
	self renderIn: categoryBuilder view.
]

{ #category : #accessing }
GTAMenuCategoryBuilder >> categoryBuilder [
	^ categoryBuilder
]

{ #category : #accessing }
GTAMenuCategoryBuilder >> categoryBuilder: anObject [
	categoryBuilder := anObject
]

{ #category : #'as yet unclassified' }
GTAMenuCategoryBuilder >> displayNumberOfActOnAndCloseEvents [
	self categoryBuilder 
		initializeNumberOfActOnAndCloseEvents;
		rebuild
]

{ #category : #'as yet unclassified' }
GTAMenuCategoryBuilder >> displayNumberOfComputersWithActOnAndCloseEvents [
	self categoryBuilder 
		initializeNumberOfComputersWithActOnAndCloseEvents;
		rebuild
]

{ #category : #'event handling' }
GTAMenuCategoryBuilder >> displayNumberOfComputersWithSelectionEvents [
	self categoryBuilder 
		initializeNumberOfComputersWithSelectionEvents;
		rebuild
]

{ #category : #'event handling' }
GTAMenuCategoryBuilder >> displayNumberOfSelectionEvents [
	self categoryBuilder 
		initializeNumberOfSelectionEvents;
		rebuild
]

{ #category : #'as yet unclassified' }
GTAMenuCategoryBuilder >> displayNumberOfSessionsWithActOnAndCloseEvents [
	self categoryBuilder 
		initializeNumberOfSessionsWithActOnAndCloseEvents;
		rebuild
]

{ #category : #'event handling' }
GTAMenuCategoryBuilder >> displayNumberOfSessionsWithSelectionEvents [
	self categoryBuilder 
		initializeNumberOfSessionsWithSelectionEvents;
		rebuild
]

{ #category : #initialization }
GTAMenuCategoryBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
]

{ #category : #hooks }
GTAMenuCategoryBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Selection Events' submenu: 'Number of Events' callback: [ self displayNumberOfSelectionEvents ].
	menuBuilder menu: 'Act-On and Close Events' submenu: 'Number of Events' callback: [ self displayNumberOfActOnAndCloseEvents ].
	categoryBuilder collection accept: self.
	menuBuilder menu: 'Sort It' callback: [ self sortIt ].
]

{ #category : #hooks }
GTAMenuCategoryBuilder >> renderMenuForComputers [
	menuBuilder menu: 'Selection Events' submenu: 'Number of Computers' callback: [ self displayNumberOfComputersWithSelectionEvents ].
	menuBuilder menu: 'Act-On and Close Events' submenu: 'Number of Computers' callback: [ self displayNumberOfComputersWithActOnAndCloseEvents ].
]

{ #category : #hooks }
GTAMenuCategoryBuilder >> renderMenuForSessions [
	menuBuilder menu: 'Selection Events' submenu: 'Number of Sessions' callback: [ self displayNumberOfSessionsWithSelectionEvents ].
	menuBuilder menu: 'Act-On and Close Events' submenu: 'Number of Sessions' callback: [ self displayNumberOfSessionsWithActOnAndCloseEvents ].
]

{ #category : #'as yet unclassified' }
GTAMenuCategoryBuilder >> sortIt [
	^ self categoryBuilder
			sortIt;
			rebuild.
]

{ #category : #visitor }
GTAMenuCategoryBuilder >> visitSomeComputers: aCollection [ 
	self 
		renderMenuForSessions;
		renderMenuForComputers.
]

{ #category : #visitor }
GTAMenuCategoryBuilder >> visitSomeSessions: aCollection [ 
	self renderMenuForSessions
]
