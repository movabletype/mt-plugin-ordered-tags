package OrderedTags::Tags;

use strict;
use MT;
use MT::Entry;
use MT::Tag;
use MT::ObjectTag;

sub ordered_tags_tag {
    my ($ctx, $args, $cond) = @_;
    
    my $entry = $ctx->stash('entry');
    return '' unless $entry;
    my $glue = $args->{glue};

    my $tags = $entry->get_tag_objects;
    my @obj_tags = ();
    for my $tag (@$tags) {
        my $obj_tag = MT::ObjectTag->load({ tag_id => $tag->id, object_id => $entry->id, object_datasource => 'entry' });
        push(@obj_tags, $obj_tag);
    }
    @obj_tags = sort { $a->order <=> $b->order } @obj_tags;

    my @final_tags = ();
    foreach my $obj_tag (@obj_tags) {
        my $tag = MT::Tag->load($obj_tag->tag_id);
        push(@final_tags, $tag);
    }

    local $ctx->{__stash}{tag_max_count} = undef;
    local $ctx->{__stash}{tag_min_count} = undef;
    local $ctx->{__stash}{all_tag_count} = undef;

    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');
    my $res = '';
    foreach my $tag (@final_tags) {
        next if $tag->is_private && !$args->{include_private};
        local $ctx->{__stash}{Tag} = $tag;
        local $ctx->{__stash}{tag_count} = undef;
        local $ctx->{__stash}{tag_entry_count} = undef;
        defined(my $out = $builder->build($ctx, $tokens, $cond)) or return $ctx->error( $builder->errstr );
        $res .= $glue if defined $glue && length($res) && length($out);
        $res .= $out;
    }
    $res;
}

sub ordered_tags_featured_tag_name {
    my ($ctx, $args, $cond) = @_;
    my $entry = $ctx->stash('entry');
    return '' unless $entry;
    my $index = $args->{index} || 1;
    my $obj_tag = MT::ObjectTag->load({ order => $index, object_id => $entry->id, object_datasource => 'entry' });
    my $tag;
    if ($obj_tag) {
        $tag = MT::Tag->load($obj_tag->tag_id);
    } else {
        $obj_tag = MT::ObjectTag->load({ object_id => $entry->id, object_datasource => 'entry' }, { limit => $index });
        if ($obj_tag) {
            $tag = MT::Tag->load($obj_tag->tag_id);
        } else {
            return '';
        }
    }
    if ($tag) {
        return $tag->name;
    }
    return '';
}

1;
