# OrderedTags

* Author: Six Apart
* Copyright 2009 Six Apart Ltd.
* License: Artistic, licensed under the same terms as Perl itself


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

**Warning:**

Entries/Pages saved prior to adding this plugin will have the current alphabetical order preserved.

### OrderedTagsFeaturedTagName

Function tag to output specific tag. Default is first tag.

    1st tag: <$mt:OrderedTagsFeaturedTagName$>
    2nd tag: <$mt:OrderedTagsFeaturedTagName index="2"$>
    3rd tag: <$mt:OrderedTagsFeaturedTagName index="3"$>


## Installation

1. Move the OrderedTags plugin directory to the MT `plugins` directory.

Should look like this when installed:

    $MT_HOME/
        plugins/
            OrderedTags/

## Requested Features

* Deprecate the tag `OrderedTags` in exchange for `sort_order` and `sort_by` attributes on the `EntryTags` tag.

    * `sort_by` - ascend (default), descend
    * `sort_order` - label (default), order, etc

    Example:

        <mt:EntryTags sort_order="ascend" sort_by="order" glue=', '><a href="<$mt:TagSearchLink$>"><$mt:TagName$></a></mt:EntryTags>


## Support

This plugin is not an official Six Apart release, and as such support from Six Apart for this plugin is not available.


## Change Log

* 2009-10-16 - v1.0 - Initial Commit
