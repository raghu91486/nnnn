#This script is created to change the inputs having strings like PP2InvoiceDescription2 to PP2E2InvoiceDescription2. And it will search all the files which file has that string that file will be edited
#And backup will be taken before editing
#List all the xml files, loop through the file list and replace
use lib '~\perllib\File-Find-Rule-0.34.tar\File-Find-Rule-0.34\File-Find-Rule-0.34\lib';
use lib '~\perllib\Number-Compare-0.03.tar\Number-Compare-0.03\Number-Compare-0.03\lib';

use File::Find::Rule;
use Cwd;

my $cwd = getcwd();

   my $includeFiles = File::Find::Rule->file
                             ->name('*.java','WS*.xml'); # search by file extensions

    my @files = File::Find::Rule->or(  $includeFiles )
                                ->in($cwd);							
foreach $file(@files) {

open(fp1,$file) or die "cannot open file\n";

@content=<fp1>;
close(fp1);
if("@content" =~/PP(\d+?)InvoiceDescription(\d+?)=/) {

print "Found in file $file\n";

open(fp2,">$file")  or die "cannot write to file\n";
foreach $cont (@content) {
        if($cont =~ /PP(\d+?)InvoiceDescription(\d+?)=/) {
                $totalAmount=$1;
                $dueAmountCount=$2;
                $toReplace="PP${totalAmount}InvoiceDescription${dueAmountCount}=";
                print $toReplace;
                $cont =~ s/$toReplace/PP${totalAmount}E${dueAmountCount}InvoiceDescription${dueAmountCount}=/g;
                print fp2 $cont;
        } else {
                print fp2 $cont;
        }
}

close(fp2);

}
}