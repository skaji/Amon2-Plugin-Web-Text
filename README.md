# NAME

Amon2::Plugin::Web::Text - provides render\_text method

# SYNOPSIS

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

# DESCRIPTION

Amon2::Plugin::Web::Text provides render\_text method to your Amon2 app.

## METHOD

### `$res = $c->render_text($string)`

### `$res = $c->render_text($status, $string)`

Generate text/plain response.
If you specify two arguments, then first is status code, second string.
If you specify just one argument, then status code is assumed to be 200.

# SEE ALSO

[Amon2::Plugin::Web::JSON](https://metacpan.org/pod/Amon2::Plugin::Web::JSON)

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@outlook.com>
