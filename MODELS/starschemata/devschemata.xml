<changeSet author="CHANGEME" id="CHANGEME">
<createTable tableName="dim_labels">
  <column name="idlabels" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="labeltype" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_labels" constraintName="dim_labels_pk" columnNames="idlabels"/>

<createTable tableName="dim_member">
  <column name="idmember" type="VARCHAR(0)" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="member" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="position" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_member" constraintName="dim_member_pk" columnNames="idmember"/>
<createSequence sequenceName="dim_member_idmember_seq"/>

<createTable tableName="dim_song">
  <column name="idsong" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_song" constraintName="dim_song_pk" columnNames="idsong"/>
<createSequence sequenceName="dim_song_idsong_seq_1"/>

<createTable tableName="dim_popularitydate">
  <column name="idpopularitydate" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="popularitymonthYear" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
  <column name="popularitymonth" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
  <column name="popularityYear" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_popularitydate" constraintName="popularitymonthYear_pk" columnNames="idpopularitydate"/>
<createSequence sequenceName="dim_popularitydate_idpopularitydate_seq"/>

<createTable tableName="fct_popularitysong">
  <column name="idsong" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idpopularitydate" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="popularitySong" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>

<createTable tableName="dim_cover">
  <column name="idcover" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="cover" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_cover" constraintName="dim_coverOrNot_pk" columnNames="idcover"/>
<createSequence sequenceName="dim_cover_idcover_seq"/>

<createTable tableName="dim_releaselocationsong">
  <column name="idreleaselocationsong" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="releasecitysong" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="releasecountrysong" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_releaselocationsong" constraintName="dim_releasecitysong_pk" columnNames="idreleaselocationsong"/>
<createSequence sequenceName="dim_releaselocationsong_idreleaselocationsong_seq_1"/>

<createTable tableName="dim_releasedatesong">
  <column name="idreleasedatesong" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="releasemonthsong" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
  <column name="releasemonthYearsong" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
  <column name="releaseyearsong" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_releasedatesong" constraintName="dim_releasemonthYearsong_pk" columnNames="idreleasedatesong"/>
<createSequence sequenceName="dim_releasedatesong_idreleasedatesong_seq"/>

<createTable tableName="dim_artistgroup">
  <column name="idartistgroup" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="cityoriginartist" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="countryoriginartist" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="typegroup" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_artistgroup" constraintName="dim_artistgroup_pk" columnNames="idartistgroup"/>

<createTable tableName="fct_popularityartist">
  <column name="idartistgroup" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idpopularitydate" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="popularityArtist" type="FLOAT">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="fct_popularityartist" constraintName="fct_popularityartist_pk" columnNames="idartistgroup"/>

<createTable tableName="dim_genre">
  <column name="idgenre" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="genretype" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_genre" constraintName="dim_genre_pk" columnNames="idgenre"/>
<createSequence sequenceName="dim_genre_idgenre_seq_1"/>

<createTable tableName="dim_album">
  <column name="idalbum" type="INTEGER" autoIncrement="true">
    <constraints nullable="false"/>
  </column>
  <column name="releasemonthYearalbum" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
  <column name="releasemonthalbum" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="releaseyearalbum" type="TIMESTAMP">
    <constraints nullable="false"/>
  </column>
</createTable>
<addPrimaryKey tableName="dim_album" constraintName="dim_album_pk" columnNames="idalbum"/>
<createSequence sequenceName="dim_album_idalbum_seq"/>

<createTable tableName="fct_song">
  <column name="idmember" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="idreleasedatesong" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idreleaselocationsong" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idalbum" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idcover" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idlabels" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="idartistgroup" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idsong" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="idgenre" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="numberReleasedCover" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="numberArtist" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="tempo" type="INTEGER">
    <constraints nullable="false"/>
  </column>
  <column name="energy" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="danceability" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="speechiness" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="accoustiness" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="loudness" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="duration" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="valence" type="FLOAT">
    <constraints nullable="false"/>
  </column>
  <column name="instrumentalness" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
  <column name="titlesong" type="VARCHAR(0)">
    <constraints nullable="false"/>
  </column>
</createTable>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="dim_labels_fct_song_fk" baseColumnNames="idlabels" referencedTableName="dim_labels" referencedColumnNames="idlabels"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="member_fct_song_fk" baseColumnNames="idmember" referencedTableName="dim_member" referencedColumnNames="idmember"/>

<addForeignKeyConstraint baseTableName="fct_popularitysong" constraintName="fct_popularitysong_dim_song_fk" baseColumnNames="idsong" referencedTableName="dim_song" referencedColumnNames="idsong"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="fct_song_dim_song_fk" baseColumnNames="idsong" referencedTableName="dim_song" referencedColumnNames="idsong"/>

<addForeignKeyConstraint baseTableName="fct_popularityartist" constraintName="fct_popularityartist_dim_popularitymonthYear_fk" baseColumnNames="idpopularitydate" referencedTableName="dim_popularitydate" referencedColumnNames="idpopularitydate"/>

<addForeignKeyConstraint baseTableName="fct_popularitysong" constraintName="dim_popularitymonthYear_fct_popularitysong_fk" baseColumnNames="idpopularitydate" referencedTableName="dim_popularitydate" referencedColumnNames="idpopularitydate"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="fct_song_dim_coverOrNot_fk" baseColumnNames="idcover" referencedTableName="dim_cover" referencedColumnNames="idcover"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="fct_song_dim_releasecitysong_fk" baseColumnNames="idreleaselocationsong" referencedTableName="dim_releaselocationsong" referencedColumnNames="idreleaselocationsong"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="fct_song_dim_releasemonthYearsong_fk" baseColumnNames="idreleasedatesong" referencedTableName="dim_releasedatesong" referencedColumnNames="idreleasedatesong"/>

<addForeignKeyConstraint baseTableName="fct_popularityartist" constraintName="fct_popularityartist_dim_artistgroup_fk" baseColumnNames="idartistgroup" referencedTableName="dim_artistgroup" referencedColumnNames="idartistgroup"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="dim_artistgroup_fct_song_fk" baseColumnNames="idartistgroup" referencedTableName="dim_artistgroup" referencedColumnNames="idartistgroup"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="fct_song_dim_genre_fk" baseColumnNames="idgenre" referencedTableName="dim_genre" referencedColumnNames="idgenre"/>

<addForeignKeyConstraint baseTableName="fct_song" constraintName="fct_song_dim_album_fk" baseColumnNames="idalbum" referencedTableName="dim_album" referencedColumnNames="idalbum"/>
</changeSet>
