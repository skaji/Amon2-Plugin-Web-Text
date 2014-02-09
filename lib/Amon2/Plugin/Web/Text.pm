package Amon2::Plugin::Web::Text;
use 5.008005;
use strict;
use warnings;
use Encode qw(encode);

our $VERSION = "0.001";

use Amon2::Util ();

sub init {
    my ($class, $c) = @_;
    unless ($c->can('render_text')) {
        Amon2::Util::add_method($c, 'render_text', sub {
            my $c = shift;
            my ($status, $string) = @_ == 1 ? (200, $_[0]) : @_;

            my $res = $c->create_response($status);

            my $encoding = $c->encoding;
            $encoding = lc($encoding->mime_name) if ref $encoding;
            $res->content_type("text/plain; charset=$encoding");

            my $output = encode($encoding, $string);
            $res->content_length(length($output));
            $res->body($output);
            return $res;
        });
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Amon2::Plugin::Web::Text - provides render_text method

=head1 SYNOPSIS

    use Amon2::Lite;
    __PACKAGE__->load_plugins('Web::Text');

    get '/' => sub {
        my $c = shift;
        return $c->render_text('hello, world.');
    };

    get '/not-found' => sub {
        my $c = shift;
        return $c->render_text( 404 => "Not found");
    };

    __PACKAGE__->to_app;

=head1 DESCRIPTION

Amon2::Plugin::Web::Text provides render_text method to your Amon2 app.

=head2 METHOD

=head3 C<< $res = $c->render_text($string) >>

=head3 C<< $res = $c->render_text($status, $string) >>

Generate text/plain response.
If you specify two arguments, then first is status code, second string.
If you specify just one argument, then status code is assumed to be 200.

=head1 SEE ALSO

L<Amon2::Plugin::Web::JSON>

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@outlook.comE<gt>

=cut

