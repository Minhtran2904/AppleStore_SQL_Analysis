CREATE DATABASE ROAD_SAFETY;
USE ROAD_SAFETY;

/*Rename Original table into "road_casualty" and first column with wrong format name into utf-8 friendly name "accident_index"*/
ALTER TABLE `dft-road-casualty-statistics-historical-revisions-data` RENAME TO road_casualty;
ALTER TABLE road_casualty RENAME COLUMN ï»¿accident_index TO accident_index;