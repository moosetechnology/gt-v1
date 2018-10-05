Class {
	#name : #BaselineOfGTInspectorCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTInspectorCore
}

{ #category : #baselines }
BaselineOfGTInspectorCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec  
			baseline: 'GlamourCore' with: [ 
				spec repository: 'github://moosetechnology/Glamour:pharo6/src' ].
		spec 
			package: 'GT-Inspector' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-InspectorExtensions-Core' with: [
				spec requires: #('GT-Inspector' 'GlamourCore' ). ];
			package: 'GT-Tests-Inspector' with: [
				spec requires: #('GT-Inspector' 'GT-InspectorExtensions-Core' ) ] ]
]
