###
Copyright (c) 2002-2011 "Neo Technology,"
Network Engine for Objects in Lund AB [http://neotechnology.com]

This file is part of Neo4j.

Neo4j is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

define(
  ['neo4j/webadmin/utils/ItemUrlResolver'
   './styleRule',
   '../models/Filters',
   '../models/filters/PropertyFilter',
   'ribcage/View',
   'lib/backbone'], 
  (ItemUrlResolver, template, Filters, PropertyFilter, View) ->
  
    class StyleRuleView extends View

      tagName : 'tr'

      events : 
        "click button.remove" : "deleteRule"

        "click button.addFilter" : "addFilter"
        "change select.target" : 'targetChanged'

      initialize : (opts) =>
        @rule = opts.rule
        @rules = opts.rules
        
      render : () =>
        $(@el).html(template())
        $('.target', @el).val @rule.getTarget()
        
        @filterContainer = $('.filters',@el)
        @rule.filters.each (filter) =>
          @addFilterElement filter
        return this
        
      targetChanged : (ev) ->
        @rule.setTarget $(ev.target).val()
        
      deleteRule : () ->
        @rules.remove @rule
        @remove()
        
      addFilter : () ->
        filter = new PropertyFilter
        @rule.filters.add filter
        @addFilterElement filter
        
      addFilterElement : (filter) ->
        FilterView = filter.getViewClass()
        view = new FilterView( {filter : filter, filters:@rule.filters} )
        @filterContainer.append view.render().el
)
