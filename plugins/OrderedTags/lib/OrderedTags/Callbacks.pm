package OrderedTags::Callbacks;

use strict;

use MT;
use MT::Tag;
use MT::ObjectTag;

sub post_save_entry {
    my ($cb, $app, $entry) = @_;
    my @tag_names = split(",",$app->param('tags'));
    my $counter = 1;
    foreach my $tag_name (@tag_names) {
        $tag_name =~ s/^ +//;
        my $tag = MT::Tag->load({ name => $tag_name });
        if ($tag) {
            my $obj_tag = MT::ObjectTag->load({ tag_id => $tag->id, object_id => $entry->id, object_datasource => 'entry' });
            $obj_tag->order($counter++);
            $obj_tag->save;
        }
    }
}

sub param_edit_entry {
    my ($cb, $app, $param, $tmpl) = @_;
    if ($param->{id}) {
        my $entry = MT::Entry->load($param->{id});
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
            push(@final_tags, $tag->name);
        }
        my $final_tag_list = join(", ", @final_tags);
        $param->{tags} = $final_tag_list;
    }
}

1;
