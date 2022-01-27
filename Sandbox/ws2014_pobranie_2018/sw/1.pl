while (<>) {
 if (/Liczba zdobytych/) {
    while (<>) {
      chomp();
      if (/<tr>/) {
      #<td style="width:50px;">4</td>
      #<td style="width:50px;">8</td>
      #<td style="width:50px;">4</td>
      #<td>KW Narodowego Odrodzenia Polski</td>
      #<td>108</td>
      #<td>DUBLAŃSKI</td>
      #<td>Kacper Jacek</td>
      #<td><table> ... style="width:0.08%; background-color:#042781;"></div></div></td><td>0.08 %</td></tr></table></td>
      #<td>N</td>
      $l1 = <>;
      $l2 = <>;
      $l3 = <>;
      $komitet = <>; $komitet = plainT($komitet);
      $glosy = <>; $glosy = plainT($glosy);
      $imie = <>; $imie = plainT($imie);
      $nazwisko = <>; $nazwisko = plainT($nazwisko);
      $l8 = <>;
      $wynik = <>; $wynik= plainT($wynik);
      if ($wynik =~ /T/) { print "$komitet;$imie;$nazwisko;$glosy;$wynik\n"; }
     }
      if (/<\/tbody>/) { exit; }
    }
 }

}

sub plainT {
  my $s = shift;
  $s =~ s/<[^<>]*>//g;
  $s =~ s/^[ \t]+|[ \t]+$|\n//g;
  $s =~ s/KW Prawo i Sprawiedliwość/PIS/g;
  $s =~ s/KW Platforma Obywatelska RP/PO/g;
  $s =~ s/Komitet Wyborczy PSL/PSL/g;
  $s =~ s/KKW SLD Lewica Razem/SLD/g;
  ####
  $s =~ s/Bezpartyjni KWW Pomorze Zachodnie/Pomorze Zachodnie/;
  $s =~ s/KW Ruch Autonomii Śląska/RAŚ/;
  $s =~ s/KWW BEZPARTYJNI SAMORZĄDOWCY/BEZPARTYJNI SAMORZĄDOWCY/;
  $s =~ s/KWW Lepsze Lubuskie - Bezpartyjny Samorząd/Lepsze Lubuskie/;
  $s =~ s/KWW Mniejszość Niemiecka/Mniejszość Niemiecka/;
  $s =~ s/KWW Ryszarda Grobelnego Teraz Wielkopolska/Grobelnego Teraz Wielkopolska/;

  ####
  return($s);
}
