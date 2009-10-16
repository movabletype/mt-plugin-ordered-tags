# OrderedTags

Author: Six Apart, Paolo Lim  
Copyright 2009 Six Apart, Ltd.  
License: Artistic, licensed under the same terms as Perl itself


## Overview

Adds order to entry/page tags.

MT sorts tags alphabetically by default; the OrderedTags plugin maintains order of tags as saved upon entry/page save or edit.

Provides two tags:

* `<mt:OrderedTags>` - loop tag to output tags in order
* `<$mt:OrderedTagsFeaturedTagName$>` - function tag to output a specific tag, first by default other specified by `index` attribute.


## Tags

### OrderedTags

Block tag returning tags in the order which they were saved.

    <mt:OrderedTags glue=', '><a href="<$mt:TagSearchLink$>"><$mt:TagName$></a></mt:OrderedTags>

*Use the `<mt:EntryTags>` loop tag to output tags in alphabetical order.*

> **Warning:** Entries/Pages saved prior to adding this plugin will have alphabetical order preserved.

### OrderedTagsFeaturedTagName

Function tag to output specific tag. Default is first tag.

    1st tag: <$mt:OrderedTagsFeaturedTagName$>
    2nd tag: <$mt:OrderedTagsFeaturedTagName index="2"$>
    3rd tag: <$mt:OrderedTagsFeaturedTagName index="3"$>

> **Warning:** Entries/Pages saved prior to adding this plugin will only be able to display the first tag, until the entry is saved again from the Edit Entry/Page screen


## Installation

1. Move the OrderedTags plugin directory to the MT `plugins` directory.

Should look like this when installed:

    $MT_HOME/
        plugins/
            OrderedTags/


## Desired Features

* initial rebuild of blog after plugin installation adds order to tags from every entry.


## Support

This plugin is not an official Six Apart release, and as such support from Six Apart for this plugin is not available.
