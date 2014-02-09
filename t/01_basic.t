use strict;
use warnings;
use Test::More;
use Encode;

{
    package MyApp;
    use parent qw/Amon2/;
}
{
    package MyApp::Web;
    use parent -norequire, qw/MyApp/;
    use parent qw/Amon2::Web/;

    __PACKAGE__->load_plugins(
        'Web::Text',
    );
    sub encoding { 'utf-8' }
}

my $c = MyApp::Web->new(request => Amon2::Web::Request->new(+{}));

subtest arg1 => sub {
    my $res = $c->render_text("hello");
    is $res->status, 200;
    is $res->header('Content-Type'), 'text/plain; charset=utf-8';
    is $res->content, 'hello';
};
subtest arg2 => sub {
    my $res = $c->render_text(404 => "not-found");
    is $res->status, 404;
    is $res->header('Content-Type'), 'text/plain; charset=utf-8';
    is $res->content, 'not-found';
};

done_testing;

