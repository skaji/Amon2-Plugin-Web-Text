use strict;
use warnings;
use utf8;
use Test::More;
use Encode qw(decode);

{ package MyUTF8; use parent qw/Amon2/ }
{
    package MyUTF8::Web;
    use parent -norequire, qw/MyUTF8/;
    use parent qw/Amon2::Web/;

    __PACKAGE__->load_plugins(
        'Web::Text',
    );
    sub encoding { 'utf-8' }
}
{ package MyEUCJP; use parent qw/Amon2/ }
{
    package MyEUCJP::Web;
    use parent -norequire, qw/MyEUCJP/;
    use parent qw/Amon2::Web/;

    __PACKAGE__->load_plugins(
        'Web::Text',
    );
    sub encoding { 'euc-jp' }
}

my $utf8   = MyUTF8::Web->new(request => Amon2::Web::Request->new(+{}));
my $euc_jp = MyEUCJP::Web->new(request => Amon2::Web::Request->new(+{}));

subtest utf8 => sub {
    my $res = $utf8->render_text("あいうえお");
    is $res->status, 200;
    is $res->header('Content-Type'), 'text/plain; charset=utf-8';
    is decode('utf-8', $res->content), "あいうえお";
};
subtest utf8_status => sub {
    my $res = $utf8->render_text(404 => "見つかりません");
    is $res->status, 404;
    is $res->header('Content-Type'), 'text/plain; charset=utf-8';
    is decode('utf-8', $res->content), "見つかりません";
};
subtest euc_jp => sub {
    my $res = $euc_jp->render_text("あいうえお");
    is $res->status, 200;
    is $res->header('Content-Type'), 'text/plain; charset=euc-jp';
    is decode('euc-jp', $res->content), "あいうえお";
};
subtest euc_jp_status => sub {
    my $res = $euc_jp->render_text(404 => "見つかりません");
    is $res->status, 404;
    is $res->header('Content-Type'), 'text/plain; charset=euc-jp';
    is decode('euc-jp', $res->content), "見つかりません";
};

done_testing;

